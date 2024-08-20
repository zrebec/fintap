package sk.zrebec.financecontroller.controller;

import sk.zrebec.financecontroller.model.Transaction;
import sk.zrebec.financecontroller.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/transactions")
public class TransactionsController {

        @Autowired
        private TransactionService transactionsService;

        @GetMapping
        public List<Transaction> getAllTransactions() {
                return transactionsService.getAllTransactions();
        }
}
