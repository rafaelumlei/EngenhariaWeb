package com.webratio.webapp;

public class Tipo implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.Integer _idtipo;

    private java.lang.String _nome;

    private java.util.Set _tipoToEvento = new java.util.HashSet();

    private float _searchScore;

    public java.lang.Integer getIdtipo() {
        return _idtipo;
    }

    public void setIdtipo(java.lang.Integer _idtipo) {
        this._idtipo = _idtipo;
    }

    public java.lang.String getNome() {
        return _nome;
    }

    public void setNome(java.lang.String _nome) {
        this._nome = _nome;
    }

    public java.util.Set getTipoToEvento() {
        return _tipoToEvento;
    }

    public void setTipoToEvento(java.util.Set _tipoToEvento) {
        this._tipoToEvento = _tipoToEvento;
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
        if (_idtipo != null)
            sb.append("idtipo=" + _idtipo + ',');
        if (_nome != null)
            sb.append("nome=" + _nome + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Tipo)) {
            return false;
        }
        Tipo otherTipo = (Tipo) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getIdtipo();
        otherKey = otherTipo.getIdtipo();
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
        key = this.getIdtipo();
        if (key != null) {
            hashCode |= key.hashCode();
        }
        return hashCode;
    }
}
