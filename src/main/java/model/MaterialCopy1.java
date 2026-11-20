package model;

public class MaterialCopy1 {
    private int id;
    private String physicalCondition;
    private String status;
    private String note;
    private Material1 material;

    public MaterialCopy1() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhysicalCondition() {
        return physicalCondition;
    }

    public void setPhysicalCondition(String physicalCondition) {
        this.physicalCondition = physicalCondition;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Material1 getMaterial() {
        return material;
    }

    public void setMaterial(Material1 material) {
        this.material = material;
    }
}
