package sk.zrebec.financecontroller.model;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;

@Entity
public class Expense extends Transaction {

    @Schema(description = "The category of the expense", example = "Food")
    private String category;

    public String getCategory() {
        return this.category;
    }

    public void setCategory(String category) {
        this.category = category;
    };

}
