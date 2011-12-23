package com.webratio.webapp;

public class Newsletter implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.String _titulo;

    private java.sql.Timestamp _dtenvio;

    private java.lang.Integer _nr;

    private com.webratio.webapp.Evento _newsletterToEvento;

    private float _searchScore;

    public java.lang.String getTitulo() {
        return _titulo;
    }

    public void setTitulo(java.lang.String _titulo) {
        this._titulo = _titulo;
    }

    public java.sql.Timestamp getDtenvio() {
        return _dtenvio;
    }

    public void setDtenvio(java.sql.Timestamp _dtenvio) {
        this._dtenvio = _dtenvio;
    }

    public java.lang.Integer getNr() {
        return _nr;
    }

    public void setNr(java.lang.Integer _nr) {
        this._nr = _nr;
    }

    public com.webratio.webapp.Evento getNewsletterToEvento() {
        return _newsletterToEvento;
    }

    public void setNewsletterToEvento(com.webratio.webapp.Evento _newsletterToEvento) {
        this._newsletterToEvento = _newsletterToEvento;
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
        if (_titulo != null)
            sb.append("titulo=" + _titulo + ',');
        if (_dtenvio != null)
            sb.append("dtenvio=" + _dtenvio + ',');
        if (_nr != null)
            sb.append("nr=" + _nr + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Newsletter)) {
            return false;
        }
        Newsletter otherNewsletter = (Newsletter) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getNr();
        otherKey = otherNewsletter.getNr();
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
        key = this.getNr();
        if (key != null) {
            hashCode |= key.hashCode();
        }
        return hashCode;
    }
}
