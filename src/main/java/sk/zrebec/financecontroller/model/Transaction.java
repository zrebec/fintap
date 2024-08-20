package sk.zrebec.financecontroller.model;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "transactions")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("id_category")
    private Long IdCategory;

    @JsonProperty("title")
    private String Title;

    @JsonProperty("price")
    private Double Price;

    @JsonProperty("id_frequency")
    private Integer IdFrequency;

    @JsonProperty("id_status")
    private Integer IdStatus;

    @JsonProperty("next_payment")
    private Date Next_Payment;

    @JsonProperty("commentary")
    private String Commentary;

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdCategory() {
        return this.IdCategory;
    }

    public void setIdCategory(Long ID_Category) {
        this.IdCategory = ID_Category;
    }

    public String getTitle() {
        return this.Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public double getPrice() {
        return this.Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public Integer getIdFrequency() {
        return this.IdFrequency;
    }

    public void setIdFrequency(Integer IdFrequency) {
        this.IdFrequency = IdFrequency;
    }

    public Integer getIdStatus() {
        return this.IdStatus;
    }

    public void setIdStatus(Integer IdStatus) {
        this.IdStatus = IdStatus;
    }

    public Date getNextPayment() {
        return this.Next_Payment;
    }

    public void setNextPayment(Date nextPayment) {
        this.Next_Payment = nextPayment;
    }

    public String getCommentary() {
        return this.Commentary;
    }

    public void setCommentary(String Commentary) {
        this.Commentary = Commentary;
    }
}
