package com.webratio.webapp;

public class Module implements java.io.Serializable {
    /** Serial version identifier. */
    private static final long serialVersionUID = 1L;

    private java.lang.Integer _oid;

    private java.lang.String _moduleID;

    private java.lang.String _moduleName;

    private java.util.Set _defaultGroups = new java.util.HashSet();

    private java.util.Set _groups = new java.util.HashSet();

    private float _searchScore;

    public java.lang.Integer getOid() {
        return _oid;
    }

    public void setOid(java.lang.Integer _oid) {
        this._oid = _oid;
    }

    public java.lang.String getModuleID() {
        return _moduleID;
    }

    public void setModuleID(java.lang.String _moduleID) {
        this._moduleID = _moduleID;
    }

    public java.lang.String getModuleName() {
        return _moduleName;
    }

    public void setModuleName(java.lang.String _moduleName) {
        this._moduleName = _moduleName;
    }

    public java.util.Set getDefaultGroups() {
        return _defaultGroups;
    }

    public void setDefaultGroups(java.util.Set _defaultGroups) {
        this._defaultGroups = _defaultGroups;
    }

    public java.util.Set getGroups() {
        return _groups;
    }

    public void setGroups(java.util.Set _groups) {
        this._groups = _groups;
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
        if (_moduleID != null)
            sb.append("moduleID=" + _moduleID + ',');
        if (_moduleName != null)
            sb.append("moduleName=" + _moduleName + ',');
        n = sb.length() - 1;
        if (sb.charAt(n) == ',') {
            sb.setCharAt(n, ']');
        } else if (sb.charAt(n) == '[') {
            sb.deleteCharAt(n);
        }
        return sb.toString();
    }

    public boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Module)) {
            return false;
        }
        Module otherModule = (Module) obj;
        java.lang.Object key = null;
        java.lang.Object otherKey = null;
        key = this.getOid();
        otherKey = otherModule.getOid();
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
