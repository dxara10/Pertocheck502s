package launcher;

import api.RestApiServer;
import visualizacao.JFramePrincipal;

public class Main {
    
    public static void main(String[] args) {
        if (args.length > 0 && args[0].equalsIgnoreCase("--api")) {
            int porta = 9090;
            if (args.length > 1) {
                try {
                    porta = Integer.parseInt(args[1]);
                } catch (NumberFormatException e) {
                    System.err.println("Porta invalida, usando porta padrao 9090");
                }
            }
            RestApiServer.iniciarServidor(porta);
        } else if (args.length > 0 && (args[0].equalsIgnoreCase("--help") || args[0].equalsIgnoreCase("-h"))) {
            mostrarAjuda();
        } else {
            iniciarGUI();
        }
    }
    
    private static void iniciarGUI() {
        java.awt.EventQueue.invokeLater(() -> {
            JFramePrincipal frame = new JFramePrincipal();
            frame.init();
            frame.setVisible(true);
        });
    }
    
    private static void mostrarAjuda() {
        System.out.println("========================================");
        System.out.println("  Pertocheck502s v2.1.0");
        System.out.println("  Impressora de Cheques Perto Check 502S");
        System.out.println("========================================");
        System.out.println();
        System.out.println("Uso:");
        System.out.println("  java -jar Pertocheck502s.jar [opcoes]");
        System.out.println();
        System.out.println("Opcoes:");
        System.out.println("  (sem parametros)    Inicia interface grafica (GUI)");
        System.out.println("  --api [porta]       Inicia servidor REST API (padrao: 9090)");
        System.out.println("  --help, -h          Mostra esta ajuda");
        System.out.println();
        System.out.println("Exemplos:");
        System.out.println("  java -jar Pertocheck502s.jar");
        System.out.println("  java -jar Pertocheck502s.jar --api");
        System.out.println("  java -jar Pertocheck502s.jar --api 9090");
        System.out.println();
        System.out.println("API REST:");
        System.out.println("  Documentacao: http://localhost:9090/api/docs");
        System.out.println("  Status: http://localhost:9090/api/status");
        System.out.println();
    }
}
