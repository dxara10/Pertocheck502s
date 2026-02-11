package comunicacao;

import com.fazecast.jSerialComm.SerialPort;
import utils.Erro;
import utils.Log;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class PchekCommModerno {

    private String portaStr;
    private boolean portaAberta;
    private SerialPort porta;
    private OutputStream out;
    private InputStream in;
    private final long TIMEOUT_DSR = 1000L;
    private final long TIMEOUT_ACK = 500L;
    private final byte ACK = 6;
    private final byte NAK = 21;
    private final int MAX_TENT = 3;
    private static String resposta;
    private final String paramString;
    private final int paramInt;

    public PchekCommModerno(String paramString, int paramInt) {
        this.paramString = paramString;
        this.paramInt = paramInt;
    }

    public void iniciaComunicacao() throws Erro {
        portaStr = paramString;
        Log.getInstance().appendLog("Tentando abrir porta: " + portaStr + " com baudRate: " + paramInt);
        
        try {
            porta = SerialPort.getCommPort(portaStr);
            
            if (porta == null) {
                throw new Erro("A1", "Porta " + portaStr + " não existe no sistema.");
            }
            
            Log.getInstance().appendLog("Porta encontrada: " + porta.getSystemPortName());
            Log.getInstance().appendLog("Porta em uso: " + porta.isOpen());
            
            porta.setBaudRate(paramInt);
            porta.setNumDataBits(8);
            porta.setNumStopBits(1);
            porta.setParity(SerialPort.NO_PARITY);
            porta.setFlowControl(SerialPort.FLOW_CONTROL_DISABLED);
            porta.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 100, 0);

            Log.getInstance().appendLog("Tentando abrir porta...");
            if (!porta.openPort()) {
                String erro = "Erro ao abrir a porta: " + paramString;
                if (porta.isOpen()) {
                    erro += " (porta já está em uso por outro programa)";
                } else {
                    erro += " (verifique se a impressora está conectada e ligada)";
                }
                throw new Erro("A2", erro);
            }

            in = porta.getInputStream();
            out = porta.getOutputStream();
            portaAberta = true;
            
            Log.getInstance().appendLog("Porta aberta com sucesso!");

        } catch (Erro e) {
            portaAberta = false;
            throw e;
        } catch (Exception e) {
            portaAberta = false;
            Log.getInstance().appendLog("Exceção ao abrir porta: " + e.getMessage());
            throw new Erro("1000", "Erro ao abrir a porta: " + paramString + " - " + e.getMessage(), e);
        }
    }

    public boolean isPortaAberta() {
        return portaAberta;
    }

    public boolean processaComando(String paramString, int paramInt) throws Erro {
        if (!portaAberta) {
            throw new Erro("A0", "Porta: " + porta.getSystemPortName() + " está fechada!");
        }

        if (!checaDSR(TIMEOUT_DSR)) {
            throw new Erro("1005", "Equipamento ocupado/desligado/desconetado!\nVerifique os cabos de conexão e tente reiniciar a impressora ou espere a impressão atual acabar.");
        }

        try {
            enviaCmd(paramString);
        } catch (Erro ex) {
            throw ex;
        }

        try {
            Protocolo protocolo = new Protocolo();
            return recebeResposta(protocolo, paramInt);
        } catch (Erro ex) {
            throw ex;
        }
    }

    public static String getResposta() {
        return resposta;
    }

    public void terminate() {
        if (portaAberta && porta != null) {
            porta.closePort();
            portaAberta = false;
        } else {
            Log.getInstance().appendLog("Porta já está fechada!");
        }
    }

    private boolean checaDSR(long paramLong) {
        long l = System.currentTimeMillis();
        do {
            if (System.currentTimeMillis() > l + paramLong) {
                return false;
            }
        } while (!porta.getDSR());
        return true;
    }

    private int getByte() {
        int i = -1;
        try {
            if (in.available() > 0) {
                i = in.read();
            }
        } catch (Exception ex) {
            return -2;
        }
        return i;
    }

    private void enviaCmd(String paramString) throws Erro {
        Protocolo localProtocolo = new Protocolo();
        localProtocolo.montaCmd(paramString);
        long l = System.currentTimeMillis();
        int j = 0;
        int i;

        do {
            try {
                out.write(localProtocolo.getBuffer());
            } catch (Exception ex) {
                throw new Erro("1001", "Erro ao escrever na porta: " + porta.getSystemPortName());
            }

            do {
                i = getByte();
                if (i == -2) {
                    throw new Erro("1002", "Erro ao ler da porta: " + porta.getSystemPortName());
                }

                if (l + TIMEOUT_ACK < System.currentTimeMillis()) {
                    throw new Erro("1007", "Tempo esgotado esperando ACK! Verifique se a impressora está conectada ao computador pela entrada [Host]");
                }
            } while ((i != 6) && (i != 21));

            if (i == 21)
                System.out.println("NAK!");
            if (i == 6)
                break;

            j++;

        } while (j < MAX_TENT);

        if (i == 21) {
            throw new Erro("1003", "NAK recebido! Tentativas de comunicação com a impressora esgotadas! Tente reiniciar a impressora.");
        }
    }

    private void enviaAck() {
        try {
            out.write(ACK);
        } catch (Exception ex) {
        }
    }

    private void enviaNak() {
        try {
            out.write(NAK);
        } catch (Exception ex) {
        }
    }

    private boolean recebeResposta(Protocolo localProtocolo, int paramInt) throws Erro {
        localProtocolo.iniciaRecepcao(1024);
        long l1 = System.currentTimeMillis();
        long l2 = paramInt * 1000L;
        int j = 0;

        do {
            boolean bool = false;

            do {
                int i = getByte();
                if (i == -2) {
                    throw new Erro("1002", "Erro ao ler na porta: " + porta.getSystemPortName());
                }

                if (l1 + l2 < System.currentTimeMillis()) {
                    throw new Erro("1004", "Tempo esgotado esperando resposta da impressora!");
                }

                if (i >= 0) {
                    bool = localProtocolo.acrescentaByte((byte) i);
                }

            } while (!bool);

            if (localProtocolo.recepcaoOk()) {
                enviaAck();
                resposta = Protocolo.getResposta();
                return true;
            }

            enviaNak();
            localProtocolo.zerarRecepcao();
            j++;

        } while (j < MAX_TENT);

        throw new Erro("1006", "Erro de protocolo! Tentativas de comunicação com a impressora esgotadas!");
    }
}
