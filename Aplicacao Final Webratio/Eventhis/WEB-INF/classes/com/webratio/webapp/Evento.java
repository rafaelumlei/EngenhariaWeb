package com.webratio.webapp;

public class Evento implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.Integer _idevento;

    private java.sql.Timestamp _dtfim;

    private java.sql.Timestamp _dtinicio;

    private java.lang.String _titulo;

    private java.lang.String _descricao;

    private java.lang.Double _lat;

    private java.lang.Double _lon;

    private java.lang.Boolean _proxnewsletter;

    private com.webratio.webapp.Tipo _eventoToTipo;

    private java.util.Set _eventoToComentario = new java.util.HashSet();

    private com.webratio.webapp.Utilizador _eventoToUtilizador;

    private java.util.Set _foimarcado = new java.util.HashSet();

    private java.util.Set _eventoToNewsletter = new java.util.HashSet();

    private float _searchScore;

    public java.lang.Integer getIdevento() {
        return _idevento;
    }

    public void setIdevento(java.lang.Integer _idevento) {
        this._idevento = _idevento;
    }

    public java.sql.Timestamp getDtfim() {
        return _dtfim;
    }

    public void setDtfim(java.sql.Timestamp _dtfim) {
        this._dtfim = _dtfim;
    }

    public java.sql.Timestamp getDtinicio() {
        return _dtinicio;
    }

    public void setDtinicio(java.sql.Timestamp _dtinicio) {
        this._dtinicio = _dtinicio;
    }

    public java.lang.String getTitulo() {
        return _titulo;
    }

    public void setTitulo(java.lang.String _titulo) {
        this._titulo = _titulo;
    }

    public java.lang.String getDescricao() {
        return _descricao;
    }

    public void setDescricao(java.lang.String _descricao) {
        this._descricao = _descricao;
    }

    public java.lang.Double getLat() {
        return _lat;
    }

    public void setLat(java.lang.Double _lat) {
        this._lat = _lat;
    }

    public java.lang.Double getLon() {
        return _lon;
    }

    public void setLon(java.lang.Double _lon) {
        this._lon = _lon;
    }

    public java.lang.Boolean getProxnewsletter() {
        return _proxnewsletter;
    }

    public void setProxnewsletter(java.lang.Boolean _proxnewsletter) {
        this._proxnewsletter = _proxnewsletter;
    }

    public com.webratio.webapp.Tipo getEventoToTipo() {
        return _eventoToTipo;
    }

    public void setEventoToTipo(com.webratio.webapp.Tipo _eventoToTipo) {
        this._eventoToTipo = _eventoToTipo;
    }

    public java.util.Set getEventoToComentario() {
        return _eventoToComentario;
    }

    public void setEventoToComentario(java.util.Set _eventoToComentario) {
        this._eventoToComentario = _eventoToComentario;
    }

    public com.webratio.webapp.Utilizador getEventoToUtilizador() {
        return _eventoToUtilizador;
    }

    public void setEventoToUtilizador(com.webratio.webapp.Utilizador _eventoToUtilizador) {
        this._eventoToUtilizador = _eventoToUtilizador;
    }

    public java.util.Set getFoimarcado() {
        return _foimarcado;
    }

    public void setFoimarcado(java.util.Set _foimarcado) {
        this._foimarcado = _foimarcado;
    }

    public java.util.Set getEventoToNewsletter() {
        return _eventoToNewsletter;
    }

    public void setEventoToNewsletter(java.util.Set _eventoToNewsletter) {
        this._eventoToNewsletter = _eventoToNewsletter;
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
        if (_idevento != null)
            sb.append("idevento=" + _idevento + ',');
        if (_dtfim != null)
            sb.append("dtfim=" + _dtfim + ',');
        if (_dtinicio != null)
            sb.append("dtinicio=" + _dtinicio + ',');
        if (_titulo != null)
            sb.append("titulo=" + _titulo + ',');
        if (_descricao != null)
            sb.append("descricao=" + _descricao + ',');
        if (_lat != null)
            sb.append("lat=" + _lat + ',');
        if (_lon != null)
            sb.append("lon=" + _lon + ',');
        if (_proxnewsletter != null)
            sb.append("proxnewsletter=" + _proxnewsletter + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Evento)) {
            return false;
        }
        Evento otherEvento = (Evento) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getIdevento();
        otherKey = otherEvento.getIdevento();
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
        key = this.getIdevento();
        if (key != null) {
            hashCode |= key.hashCode();
        }
        return hashCode;
    }
}
