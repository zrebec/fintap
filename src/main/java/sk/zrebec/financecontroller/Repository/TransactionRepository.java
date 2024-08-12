package sk.zrebec.financecontroller.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import sk.zrebec.financecontroller.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
}
