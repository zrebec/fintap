package sk.zrebec.financecontroller.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import sk.zrebec.financecontroller.Repository.TransactionRepository;
import sk.zrebec.financecontroller.model.Transaction;

@Service
public class TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll(Sort.by(Sort.Direction.DESC, "date"));
    }

    public Optional<Transaction> geTransactionById(Long id) {
        return transactionRepository.findById(id);
    }

    public Transaction saveTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    public void deleteAllTransactions() {
        transactionRepository.deleteAll();
    }

    public void resetTransactionSequence() {
        jdbcTemplate.execute("ALTER SEQUENCE transaction_id_seq RESTART WITH 1");
    }

}
