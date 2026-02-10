@echo off
echo ========================================
echo  Teste da API REST - Pertocheck502s
echo ========================================
echo.

echo [1/3] Testando endpoint de status...
curl -s http://localhost:8080/api/status
echo.
echo.

echo [2/3] Testando impressao de cheque...
curl -X POST http://localhost:8080/api/cheque/imprimir ^
  -H "Content-Type: application/json" ^
  -d "{\"valor\":\"1250.50\",\"valorExtenso\":\"Mil duzentos e cinquenta reais\",\"beneficiario\":\"JOSE DA SILVA\",\"cidade\":\"SAO PAULO\",\"data\":\"09/02/2026\",\"numeroBanco\":\"123\"}"
echo.
echo.

echo [3/3] Abrindo documentacao no navegador...
start http://localhost:8080/api/docs

echo.
echo ========================================
echo  Testes concluidos!
echo ========================================
pause
