package api;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import spark.Request;
import spark.Response;
import utils.Erro;
import utils.Log;

import static spark.Spark.*;

public class RestApiServer {

    private static final Gson gson = new Gson();
    private static final ChequeService chequeService = new ChequeService();
    private static final int DEFAULT_PORT = 8080;

    public static void main(String[] args) {
        iniciarServidor(DEFAULT_PORT);
    }

    public static void iniciarServidor(int porta) {
        port(porta);
        
        configurarCORS();
        configurarRotas();
        
        Log.getInstance().appendLog("API REST iniciada na porta " + porta);
        System.out.println("========================================");
        System.out.println("  API REST - Pertocheck502s v2.1.0");
        System.out.println("========================================");
        System.out.println("Servidor rodando em: http://localhost:" + porta);
        System.out.println("Documentacao: http://localhost:" + porta + "/api/docs");
        System.out.println("========================================");
    }

    private static void configurarCORS() {
        before((request, response) -> {
            response.header("Access-Control-Allow-Origin", "*");
            response.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            response.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
        });

        options("/*", (request, response) -> {
            String accessControlRequestHeaders = request.headers("Access-Control-Request-Headers");
            if (accessControlRequestHeaders != null) {
                response.header("Access-Control-Allow-Headers", accessControlRequestHeaders);
            }
            return "OK";
        });
    }

    private static void configurarRotas() {
        get("/", (req, res) -> {
            res.redirect("/api/docs");
            return null;
        });

        get("/api/docs", RestApiServer::documentacao);
        get("/api/status", RestApiServer::status);
        post("/api/cheque/imprimir", RestApiServer::imprimirCheque);
        
        notFound((req, res) -> {
            res.type("application/json");
            return gson.toJson(new ApiResponse(false, "Endpoint nao encontrado"));
        });

        exception(Exception.class, (exception, request, response) -> {
            response.type("application/json");
            response.status(500);
            Log.getInstance().appendLog("API: Erro - " + exception.getMessage());
            response.body(gson.toJson(new ApiResponse(false, "Erro interno: " + exception.getMessage())));
        });
    }

    private static String documentacao(Request req, Response res) {
        res.type("text/html");
        return "<!DOCTYPE html>" +
                "<html><head><meta charset='UTF-8'><title>API Pertocheck502s</title>" +
                "<style>body{font-family:Arial;max-width:800px;margin:50px auto;padding:20px}" +
                "h1{color:#2c3e50}h2{color:#34495e;border-bottom:2px solid #3498db;padding-bottom:10px}" +
                "pre{background:#f4f4f4;padding:15px;border-radius:5px;overflow-x:auto}" +
                ".endpoint{background:#e8f5e9;padding:10px;margin:10px 0;border-radius:5px}" +
                ".method{color:#fff;padding:5px 10px;border-radius:3px;font-weight:bold}" +
                ".post{background:#4caf50}.get{background:#2196f3}" +
                "</style></head><body>" +
                "<h1>API REST - Pertocheck502s v2.1.0</h1>" +
                "<p>API para impressao de cheques via requisicoes HTTP</p>" +
                
                "<h2>Endpoints Disponiveis</h2>" +
                
                "<div class='endpoint'>" +
                "<span class='method get'>GET</span> <strong>/api/status</strong>" +
                "<p>Verifica o status da API</p>" +
                "<pre>curl http://localhost:8080/api/status</pre>" +
                "</div>" +
                
                "<div class='endpoint'>" +
                "<span class='method post'>POST</span> <strong>/api/cheque/imprimir</strong>" +
                "<p>Imprime um cheque com os dados fornecidos</p>" +
                "<h3>Parametros (JSON):</h3>" +
                "<ul>" +
                "<li><strong>valor</strong> (obrigatorio): Valor do cheque (ex: 1250.50)</li>" +
                "<li><strong>valorExtenso</strong> (opcional): Valor por extenso</li>" +
                "<li><strong>beneficiario</strong> (obrigatorio): Nome do beneficiario</li>" +
                "<li><strong>cidade</strong> (obrigatorio): Cidade</li>" +
                "<li><strong>data</strong> (obrigatorio): Data no formato dd/mm/aaaa</li>" +
                "<li><strong>numeroBanco</strong> (opcional): Numero do banco</li>" +
                "</ul>" +
                "<h3>Exemplo de Requisicao:</h3>" +
                "<pre>curl -X POST http://localhost:8080/api/cheque/imprimir \\\n" +
                "  -H \"Content-Type: application/json\" \\\n" +
                "  -d '{\n" +
                "    \"valor\": \"1250.50\",\n" +
                "    \"valorExtenso\": \"Mil duzentos e cinquenta reais e cinquenta centavos\",\n" +
                "    \"beneficiario\": \"JOSE DA SILVA\",\n" +
                "    \"cidade\": \"SAO PAULO\",\n" +
                "    \"data\": \"09/02/2026\",\n" +
                "    \"numeroBanco\": \"123\"\n" +
                "  }'</pre>" +
                "<h3>Resposta de Sucesso:</h3>" +
                "<pre>{\n" +
                "  \"sucesso\": true,\n" +
                "  \"mensagem\": \"Cheque impresso com sucesso\"\n" +
                "}</pre>" +
                "<h3>Resposta de Erro:</h3>" +
                "<pre>{\n" +
                "  \"sucesso\": false,\n" +
                "  \"mensagem\": \"Erro ao imprimir: ...\"\n" +
                "}</pre>" +
                "</div>" +
                
                "<h2>Codigos de Status HTTP</h2>" +
                "<ul>" +
                "<li><strong>200</strong> - Sucesso</li>" +
                "<li><strong>400</strong> - Requisicao invalida</li>" +
                "<li><strong>404</strong> - Endpoint nao encontrado</li>" +
                "<li><strong>500</strong> - Erro interno do servidor</li>" +
                "</ul>" +
                
                "<h2>Exemplos em Diferentes Linguagens</h2>" +
                
                "<h3>JavaScript (Fetch API)</h3>" +
                "<pre>fetch('http://localhost:8080/api/cheque/imprimir', {\n" +
                "  method: 'POST',\n" +
                "  headers: { 'Content-Type': 'application/json' },\n" +
                "  body: JSON.stringify({\n" +
                "    valor: '1250.50',\n" +
                "    beneficiario: 'JOSE DA SILVA',\n" +
                "    cidade: 'SAO PAULO',\n" +
                "    data: '09/02/2026'\n" +
                "  })\n" +
                "})\n" +
                ".then(res => res.json())\n" +
                ".then(data => console.log(data));</pre>" +
                
                "<h3>Python (requests)</h3>" +
                "<pre>import requests\n\n" +
                "response = requests.post('http://localhost:8080/api/cheque/imprimir',\n" +
                "  json={\n" +
                "    'valor': '1250.50',\n" +
                "    'beneficiario': 'JOSE DA SILVA',\n" +
                "    'cidade': 'SAO PAULO',\n" +
                "    'data': '09/02/2026'\n" +
                "  })\n\n" +
                "print(response.json())</pre>" +
                
                "<h3>C# (HttpClient)</h3>" +
                "<pre>var client = new HttpClient();\n" +
                "var content = new StringContent(\n" +
                "  JsonSerializer.Serialize(new {\n" +
                "    valor = \"1250.50\",\n" +
                "    beneficiario = \"JOSE DA SILVA\",\n" +
                "    cidade = \"SAO PAULO\",\n" +
                "    data = \"09/02/2026\"\n" +
                "  }),\n" +
                "  Encoding.UTF8,\n" +
                "  \"application/json\"\n" +
                ");\n\n" +
                "var response = await client.PostAsync(\n" +
                "  \"http://localhost:8080/api/cheque/imprimir\",\n" +
                "  content\n" +
                ");</pre>" +
                
                "</body></html>";
    }

    private static String status(Request req, Response res) {
        res.type("application/json");
        return gson.toJson(new ApiResponse(true, "API funcionando", 
            new java.util.HashMap<String, String>() {{
                put("versao", "2.1.0");
                put("status", "online");
                put("timestamp", new java.util.Date().toString());
            }}
        ));
    }

    private static String imprimirCheque(Request req, Response res) {
        res.type("application/json");
        
        try {
            ChequeRequest chequeRequest = gson.fromJson(req.body(), ChequeRequest.class);
            
            if (chequeRequest.getValor() == null || chequeRequest.getValor().isEmpty()) {
                res.status(400);
                return gson.toJson(new ApiResponse(false, "Campo 'valor' e obrigatorio"));
            }
            
            if (chequeRequest.getBeneficiario() == null || chequeRequest.getBeneficiario().isEmpty()) {
                res.status(400);
                return gson.toJson(new ApiResponse(false, "Campo 'beneficiario' e obrigatorio"));
            }
            
            if (chequeRequest.getCidade() == null || chequeRequest.getCidade().isEmpty()) {
                res.status(400);
                return gson.toJson(new ApiResponse(false, "Campo 'cidade' e obrigatorio"));
            }
            
            if (chequeRequest.getData() == null || chequeRequest.getData().isEmpty()) {
                res.status(400);
                return gson.toJson(new ApiResponse(false, "Campo 'data' e obrigatorio"));
            }
            
            chequeService.imprimirCheque(chequeRequest);
            
            return gson.toJson(new ApiResponse(true, "Cheque impresso com sucesso"));
            
        } catch (JsonSyntaxException e) {
            res.status(400);
            return gson.toJson(new ApiResponse(false, "JSON invalido: " + e.getMessage()));
        } catch (Erro e) {
            res.status(500);
            return gson.toJson(new ApiResponse(false, "Erro ao imprimir: " + e.print()));
        } catch (Exception e) {
            res.status(500);
            return gson.toJson(new ApiResponse(false, "Erro inesperado: " + e.getMessage()));
        }
    }
}
