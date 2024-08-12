package sk.zrebec.financecontroller.model;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = Expense.class, name = "Expense"),
        @JsonSubTypes.Type(value = Income.class, name = "Income")
})
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(hidden = true)
    private Long id;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Schema(description = "The transaction date in YYYY-MM-DD format", example = "2024-08-01")
    @NotNull(message = "Date is required")
    private LocalDate date;

    @Schema(description = "The transaction amount", example = "150.00")
    @Positive(message = "Amount must be positive")
    private double amount;

    @Schema(description = "The for the transaction", example = "Grocerie shopping")
    private String note;

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return this.date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public double getAmount() {
        return this.amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getNote() {
        return this.note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
