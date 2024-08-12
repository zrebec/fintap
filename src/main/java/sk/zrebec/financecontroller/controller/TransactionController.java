package sk.zrebec.financecontroller.controller;

import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import sk.zrebec.financecontroller.model.Transaction;
import sk.zrebec.financecontroller.service.TransactionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/transactions")
public class TransactionController {

        @Autowired
        private TransactionService transactionService;

        @Operation(summary = "Retrieve all transactions")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Found the transactions", content = {
                                        @Content(mediaType = "application/json", schema = @Schema(implementation = Transaction.class)) }),
                        @ApiResponse(responseCode = "404", description = "Transactions not found", content = @Content)
        })
        @GetMapping
        public List<Transaction> getAllTransactions() {
                return transactionService.getAllTransactions();
        }

        @Operation(summary = "Get a transaction by its ID")
        @GetMapping("/id/{id}")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "200", description = "Found the transaction", content = {
                                        @Content(mediaType = "application/json", schema = @Schema(implementation = Transaction.class)) }),
                        @ApiResponse(responseCode = "404", description = "Transaction not found", content = @Content)
        })
        public ResponseEntity<Transaction> getTransactionById(@PathVariable Long id) {
                Optional<Transaction> transaction = transactionService.geTransactionById(id);
                return transaction.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
        }

        @Operation(summary = "Create a new transaction")
        @ApiResponses(value = {
                        @ApiResponse(responseCode = "201", description = "Transaction created", content = {
                                        @Content(mediaType = "application/json", schema = @Schema(implementation = Transaction.class)) }),
                        @ApiResponse(responseCode = "400", description = "Invalid transaction type", content = @Content)
        })
        @PostMapping
        public ResponseEntity<Transaction> creatTransaction(@Valid @RequestBody Transaction transaction) {
                Transaction createdTransaction = transactionService.saveTransaction(transaction);
                return ResponseEntity.status(HttpStatus.CREATED).body(createdTransaction);
        }

        // Restricted deleteAllTransactions method (not exposed as an API endpoint)
        public void deleteAllTransactions() {
                transactionService.deleteAllTransactions();
        }
}
