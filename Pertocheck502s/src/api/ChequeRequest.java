package api;

public class ChequeRequest {
    private String numeroBanco;
    private String valor;
    private String valorExtenso;
    private String beneficiario;
    private String cidade;
    private String data;

    public String getNumeroBanco() {
        return numeroBanco;
    }

    public void setNumeroBanco(String numeroBanco) {
        this.numeroBanco = numeroBanco;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getValorExtenso() {
        return valorExtenso;
    }

    public void setValorExtenso(String valorExtenso) {
        this.valorExtenso = valorExtenso;
    }

    public String getBeneficiario() {
        return beneficiario;
    }

    public void setBeneficiario(String beneficiario) {
        this.beneficiario = beneficiario;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ChequeRequest{" +
                "numeroBanco='" + numeroBanco + '\'' +
                ", valor='" + valor + '\'' +
                ", valorExtenso='" + valorExtenso + '\'' +
                ", beneficiario='" + beneficiario + '\'' +
                ", cidade='" + cidade + '\'' +
                ", data='" + data + '\'' +
                '}';
    }
}
