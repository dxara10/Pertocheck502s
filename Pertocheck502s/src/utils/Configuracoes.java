/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author rhuan
 */
public class Configuracoes {

    
    /**
     * Método para ler o arquivo de configurações e retornar os paramtros das configurações
     * @return UErro
     * @throws utils.Erro
     */
    public List<String> lerConfiguracoesArquivo() throws Erro {
        
        String parametros[];
        List<String> param = new ArrayList();
        
        try {
            
            if(!existeArquivo()) {
                Log.getInstance().appendLog("Arquivo de configuração não encontrado em: " + Constantes.DIRETORIO_TEMP + Constantes.ARQUIVO_CONFIGURACOES);
                Log.getInstance().appendLog("Criando arquivo de configuração padrão...");
                criarArquivoConfigPadrao();
            }
            
            Log.getInstance().appendLog("Arquivo de configuração [config.txt] encontrado com sucesso!");
            List<String> configs = lerArquivo();
            
            if(configs == null || configs.isEmpty()) {
                throw new Erro("A", "Arquivo de configuração vazio, contate o suporte!");
            }
            
            for (String conf : configs) {
                
                if(conf.trim().isEmpty() || conf.trim().startsWith("#")) {
                    continue;
                }
                
                parametros = conf.split(Pattern.quote("=")); //recupera só os valores depois do '='
                if(parametros.length <= 1) {
                    if(conf.contains("DIRETORIO=")) {
                        param.add("");
                        continue;
                    }
                    throw new Erro ("B", "Parametros do arquivo de configurações incorretos ou não preenchidos, contate o suporte!");
                }
                
                if(parametros[1] != null && !parametros[1].trim().isEmpty()) {
                    param.add(parametros[1].trim());
                } else {
                    if(parametros[0].toUpperCase().contains("DIRETORIO")) {
                        param.add("");
                    } else {
                        throw new Erro ("C", "Parametros do arquivo de configurações incorretos ou não preenchidos, contate o suporte!");
                    }
                }
            }
            
        } catch (IOException ex) {
            throw new Erro("E",  "Falha na leitura do arquivo de configurações" , ex);
        }
        
        return param;
    }
    
    
    private void criarArquivoConfigPadrao() throws IOException {
        List<String> linhas = new ArrayList<>();
        linhas.add("# Configuração da Impressora Perto Check 502S");
        linhas.add("# Versão 2.1.0");
        linhas.add("");
        linhas.add("# Porta Serial (COM1, COM2, COM3, COM4, etc)");
        linhas.add("PORTA=COM1");
        linhas.add("");
        linhas.add("# Taxa de transmissão em bits por segundo");
        linhas.add("# Valores comuns: 9600, 19200, 38400, 57600, 115200");
        linhas.add("BITS_PER_SECOND=9600");
        linhas.add("");
        linhas.add("# Diretório padrão para seleção de arquivos (opcional)");
        linhas.add("# Deixe em branco para usar o diretório padrão do sistema");
        linhas.add("DIRETORIO=");
        
        UArquivos.escrever(Constantes.DIRETORIO_TEMP + Constantes.ARQUIVO_CONFIGURACOES, linhas);
        Log.getInstance().appendLog("Arquivo de configuração criado em: " + Constantes.DIRETORIO_TEMP + Constantes.ARQUIVO_CONFIGURACOES);
    }
    
    
    
    
    /**
     * Recupera o arquivo no class path do projeto
    */
    private List<String> lerArquivo() {
        try {
            return UArquivos.ler(Constantes.DIRETORIO_TEMP + Constantes.ARQUIVO_CONFIGURACOES);
        } catch (IOException ex) {
        }
        return null;
    }

    /**
     * Recupera o arquivo no class path do projeto
    */
    private boolean existeArquivo() throws IOException {
        return UArquivos.arquivoExiste(Constantes.DIRETORIO_TEMP + Constantes.ARQUIVO_CONFIGURACOES);
    }    
    
}
