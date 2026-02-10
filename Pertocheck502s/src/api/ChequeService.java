package api;

import controle.CCheque;
import negocio.NCheque;
import utils.Erro;
import utils.Log;
import utils.UTratamentoDadosArquivo;

public class ChequeService {

    public void imprimirCheque(ChequeRequest request) throws Erro {
        Log.getInstance().appendLog("API: Recebida requisicao de impressao: " + request.toString());
        
        NCheque cheque = new NCheque();
        UTratamentoDadosArquivo tratamento = new UTratamentoDadosArquivo();
        
        cheque.setData(tratamento.yearFourToTwoChars(tratamento.removeSeparadorData(request.getData())));
        cheque.setCidade(tratamento.removerAcentos(request.getCidade()));
        cheque.setBeneficiario(tratamento.removerAcentos(request.getBeneficiario()));
        
        String valor = tratamento.removeSeparadorMonetario(request.getValor());
        valor = tratamento.concatenarZerosAEsquerda(valor, 12);
        
        if (request.getNumeroBanco() != null && !request.getNumeroBanco().isEmpty()) {
            cheque.setValor(valor, "2", request.getNumeroBanco());
        } else {
            cheque.setValor(valor, "2");
        }
        
        Log.getInstance().appendLog("API: Cheque preparado: " + cheque.toString());
        
        CCheque ccheque = new CCheque(cheque);
        
        try {
            Log.getInstance().appendLog("API: Iniciando impressora");
            ccheque.iniciaImpressora();
            
            ccheque.alteraData();
            ccheque.alteraBeneficiario();
            ccheque.alteraCidade();
            
            ccheque.leituraCheque();
            Log.getInstance().appendLog("API: Leitura do cheque realizada");
            
            ccheque.preencheCheque();
            Log.getInstance().appendLog("API: Cheque preenchido com sucesso");
            
            ccheque.stopImpressora();
            Log.getInstance().appendLog("API: Impressao concluida");
            
        } catch (Erro ex) {
            ccheque.stopImpressora();
            throw ex;
        }
    }
}
