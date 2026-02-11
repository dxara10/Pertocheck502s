package utils;

import com.fazecast.jSerialComm.SerialPort;

public class PortasDisponiveis {
    
    public static void listarPortas() {
        System.out.println("========================================");
        System.out.println("  Portas Seriais Disponíveis");
        System.out.println("========================================");
        
        SerialPort[] portas = SerialPort.getCommPorts();
        
        if (portas.length == 0) {
            System.out.println("Nenhuma porta serial encontrada!");
            System.out.println();
            System.out.println("Verifique:");
            System.out.println("- Se a impressora está conectada");
            System.out.println("- Se o cabo USB-Serial está conectado");
            System.out.println("- Se o driver está instalado");
        } else {
            System.out.println("Total de portas encontradas: " + portas.length);
            System.out.println();
            
            for (SerialPort porta : portas) {
                System.out.println("Porta: " + porta.getSystemPortName());
                System.out.println("  Descrição: " + porta.getDescriptivePortName());
                System.out.println("  Em uso: " + (porta.isOpen() ? "Sim" : "Não"));
                System.out.println();
            }
        }
        
        System.out.println("========================================");
    }
    
    public static void main(String[] args) {
        listarPortas();
    }
}
