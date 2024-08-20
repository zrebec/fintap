package sk.zrebec.financecontroller;

import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import sk.zrebec.financecontroller.model.Transaction;
import sk.zrebec.financecontroller.service.TransactionService;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private TransactionService transactionsService;

    @Override
    public void run(String... args) throws Exception {
        transactionsService.deleteAllTransactions();

        // Read Json File
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());

        InputStream inputStream = new ClassPathResource("transactions.json").getInputStream();
        List<Transaction> transactions = objectMapper.readValue(inputStream, new TypeReference<List<Transaction>>() {
        });

        for (Transaction transaction : transactions) {
            System.out.println("Saving transaction: " + transaction.getTitle());
            transactionsService.saveTransaction(transaction);
        }
    }
}
