package com.webratio.webapp;

public class Utilizador implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.Integer _oid;

    private java.lang.String _userName;

    private java.lang.String _password;

    private java.lang.String _email;

    private java.lang.String _nome;

    private java.lang.String _foto;

    private java.lang.Double _lat1;

    private java.lang.Double _lon1;

    private java.lang.Double _lat2;

    private java.lang.Double _lon2;

    private java.lang.String _testeRef;

    private java.lang.Object _teste;

    private java.util.Set _groups = new java.util.HashSet();

    private com.webratio.webapp.Grupo _defaultGroup;

    private java.util.Set _utilizadorToComentario = new java.util.HashSet();

    private java.util.Set _utilizadorToEvento = new java.util.HashSet();

    private java.util.Set _marca = new java.util.HashSet();

    private float _searchScore;

    public java.lang.Integer getOid() {
        return _oid;
    }

    public void setOid(java.lang.Integer _oid) {
        this._oid = _oid;
    }

    public java.lang.String getUserName() {
        return _userName;
    }

    public void setUserName(java.lang.String _userName) {
        this._userName = _userName;
    }

    public java.lang.String getPassword() {
        return _password;
    }

    public void setPassword(java.lang.String _password) {
        this._password = _password;
    }

    public java.lang.String getEmail() {
        return _email;
    }

    public void setEmail(java.lang.String _email) {
        this._email = _email;
    }

    public java.lang.String getNome() {
        return _nome;
    }

    public void setNome(java.lang.String _nome) {
        this._nome = _nome;
    }

    public java.lang.String getFoto() {
        return _foto;
    }

    public void setFoto(java.lang.String _foto) {
        this._foto = _foto;
    }

    public java.lang.Double getLat1() {
        return _lat1;
    }

    public void setLat1(java.lang.Double _lat1) {
        this._lat1 = _lat1;
    }

    public java.lang.Double getLon1() {
        return _lon1;
    }

    public void setLon1(java.lang.Double _lon1) {
        this._lon1 = _lon1;
    }

    public java.lang.Double getLat2() {
        return _lat2;
    }

    public void setLat2(java.lang.Double _lat2) {
        this._lat2 = _lat2;
    }

    public java.lang.Double getLon2() {
        return _lon2;
    }

    public void setLon2(java.lang.Double _lon2) {
        this._lon2 = _lon2;
    }

    public java.lang.String getTesteRef() {
        return _testeRef;
    }

    public void setTesteRef(java.lang.String _testeRef) {
        this._testeRef = _testeRef;
    }

    public java.lang.Object getTeste() {
        return _teste;
    }

    public void setTeste(java.lang.Object _teste) {
        this._teste = _teste;
    }

    public java.util.Set getGroups() {
        return _groups;
    }

    public void setGroups(java.util.Set _groups) {
        this._groups = _groups;
    }

    public com.webratio.webapp.Grupo getDefaultGroup() {
        return _defaultGroup;
    }

    public void setDefaultGroup(com.webratio.webapp.Grupo _defaultGroup) {
        this._defaultGroup = _defaultGroup;
    }

    public java.util.Set getUtilizadorToComentario() {
        return _utilizadorToComentario;
    }

    public void setUtilizadorToComentario(java.util.Set _utilizadorToComentario) {
        this._utilizadorToComentario = _utilizadorToComentario;
    }

    public java.util.Set getUtilizadorToEvento() {
        return _utilizadorToEvento;
    }

    public void setUtilizadorToEvento(java.util.Set _utilizadorToEvento) {
        this._utilizadorToEvento = _utilizadorToEvento;
    }

    public java.util.Set getMarca() {
        return _marca;
    }

    public void setMarca(java.util.Set _marca) {
        this._marca = _marca;
    }

    public float getSearchScore() {
        return _searchScore;
    }

    public void setSearchScore(float _searchScore) {
        this._searchScore = _searchScore;
    }

    public String toString() {
        java.lang.StringBuffer sb = new java.lang.StringBuffer();
        sb.append(super.toString());
        int n = sb.length() - 1;
        if (sb.charAt(n) == ']') {
            sb.setCharAt(n, ',');
        } else {
            sb.append('[');
        }
        if (_oid != null)
            sb.append("oid=" + _oid + ',');
        if (_userName != null)
            sb.append("userName=" + _userName + ',');
        if (_password != null)
            sb.append("password=" + _password + ',');
        if (_email != null)
            sb.append("email=" + _email + ',');
        if (_nome != null)
            sb.append("nome=" + _nome + ',');
        if (_foto != null)
            sb.append("foto=" + _foto + ',');
        if (_lat1 != null)
            sb.append("lat1=" + _lat1 + ',');
        if (_lon1 != null)
            sb.append("lon1=" + _lon1 + ',');
        if (_lat2 != null)
            sb.append("lat2=" + _lat2 + ',');
        if (_lon2 != null)
            sb.append("lon2=" + _lon2 + ',');
        if (_teste != null)
            sb.append("teste=" + _teste + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Utilizador)) {
            return false;
        }
        Utilizador otherUtilizador = (Utilizador) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getOid();
        otherKey = otherUtilizador.getOid();
        if (key == null) {
            if (otherKey != null) {
                return false;
            }
        } else {
            if (otherKey == null) {
                return false;
            } else if (!key.equals(otherKey)) {
                return false;
            }
        }
        return true;
    }

    public int hashCode() {
        int hashCode = 0;
        java.lang.Object key = null;
        key = this.getOid();
        if (key != null) {
            hashCode |= key.hashCode();
        }
        return hashCode;
    }
}
