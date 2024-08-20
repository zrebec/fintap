package sk.zrebec.financecontroller.service;

import sk.zrebec.financecontroller.Repository.TransactionsRepository;
import sk.zrebec.financecontroller.model.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionService {

    @Autowired
    private TransactionsRepository transactions;

    public List<Transaction> getAllTransactions() {
        return transactions.findAll();
    }

    public void deleteAllTransactions() {
        transactions.deleteAll();
    }

    public Transaction saveTransaction(Transaction t) {
        return transactions.save(t);
    }
}
