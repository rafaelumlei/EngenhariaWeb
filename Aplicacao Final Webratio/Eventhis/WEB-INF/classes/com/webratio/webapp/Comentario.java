package com.webratio.webapp;

public class Comentario implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.Integer _idcomentario;

    private java.lang.String _titulo;

    private java.lang.String _texto;

    private java.sql.Timestamp _dtcom;

    private com.webratio.webapp.Utilizador _comentarioToUtilizador;

    private com.webratio.webapp.Evento _comentarioToEvento;

    private float _searchScore;

    public java.lang.Integer getIdcomentario() {
        return _idcomentario;
    }

    public void setIdcomentario(java.lang.Integer _idcomentario) {
        this._idcomentario = _idcomentario;
    }

    public java.lang.String getTitulo() {
        return _titulo;
    }

    public void setTitulo(java.lang.String _titulo) {
        this._titulo = _titulo;
    }

    public java.lang.String getTexto() {
        return _texto;
    }

    public void setTexto(java.lang.String _texto) {
        this._texto = _texto;
    }

    public java.sql.Timestamp getDtcom() {
        return _dtcom;
    }

    public void setDtcom(java.sql.Timestamp _dtcom) {
        this._dtcom = _dtcom;
    }

    public com.webratio.webapp.Utilizador getComentarioToUtilizador() {
        return _comentarioToUtilizador;
    }

    public void setComentarioToUtilizador(com.webratio.webapp.Utilizador _comentarioToUtilizador) {
        this._comentarioToUtilizador = _comentarioToUtilizador;
    }

    public com.webratio.webapp.Evento getComentarioToEvento() {
        return _comentarioToEvento;
    }

    public void setComentarioToEvento(com.webratio.webapp.Evento _comentarioToEvento) {
        this._comentarioToEvento = _comentarioToEvento;
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
        if (_idcomentario != null)
            sb.append("idcomentario=" + _idcomentario + ',');
        if (_titulo != null)
            sb.append("titulo=" + _titulo + ',');
        if (_texto != null)
            sb.append("texto=" + _texto + ',');
        if (_dtcom != null)
            sb.append("dtcom=" + _dtcom + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Comentario)) {
            return false;
        }
        Comentario otherComentario = (Comentario) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getIdcomentario();
        otherKey = otherComentario.getIdcomentario();
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
        key = this.getIdcomentario();
        if (key != null) {
            hashCode |= key.hashCode();
        }
        return hashCode;
    }
}
