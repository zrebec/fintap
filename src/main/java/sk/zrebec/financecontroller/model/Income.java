package sk.zrebec.financecontroller.model;

import jakarta.persistence.Entity;

@Entity
public class Income extends Transaction {

    private String source;

    // Getters and Setters
    public String getSource() {
        return this.source;
    }

    public void setSource(String source) {
        this.source = source;
    }

}
