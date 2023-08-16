package com.api.pizza.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.api.pizza.entity.Product;
import com.api.pizza.repository.IProductRepository;

@RestController
@CrossOrigin
@RequestMapping("/")
public class ProductController {
    @Autowired
    IProductRepository gProductRepository;

    // get all Product
    @GetMapping("/products")
    public ResponseEntity<List<Product>> getAllProducts() {
        try {
            List<Product> productList = gProductRepository.findAll();
            Long totalElement = (long) productList.size();

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(productList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // create new product
    @PostMapping("/products")
    public ResponseEntity<Object> createNewProduct(
            @Valid @RequestBody Product pProduct) {
        try {
            Product vProduct = new Product();
            vProduct.setProductCode(pProduct.getProductCode());
            vProduct.setProductName(pProduct.getProductName());
            vProduct.setCreatedDate(new Date());

            Product vProductSave = gProductRepository.save(vProduct);
            return new ResponseEntity<>(vProductSave, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity()
                    .body("Failed to Create specified Product: " + e.getCause().getCause().getMessage());
        }

    }

    // get product by id
    @GetMapping("/products/{productId}")
    public ResponseEntity<Object> getNameById(
            @PathVariable Integer productId) {
        Optional<Product> vProductData = gProductRepository.findById(productId);
        if (vProductData.isPresent()) {
            try {
                Product vProduct = vProductData.get();
                return new ResponseEntity<>(vProduct, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Product vProductNull = new Product();
            return new ResponseEntity<>(vProductNull, HttpStatus.NOT_FOUND);
        }
    }

    // Update product by id
    @PutMapping("/products/{productId}")
    public ResponseEntity<Object> updateProduct(
            @PathVariable Integer productId,
            @Valid @RequestBody Product pProduct) {
        Optional<Product> vProductData = gProductRepository.findById(productId);
        if (vProductData.isPresent()) {
            try {
                Product vProduct = vProductData.get();
                vProduct.setProductCode(pProduct.getProductCode());
                vProduct.setProductName(pProduct.getProductName());
                vProduct.setUpdatedDate(new Date());

                Product vProductSave = gProductRepository.save(vProduct);
                return new ResponseEntity<>(vProductSave, HttpStatus.OK);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Update specified Product: " + e.getCause().getCause().getMessage());
            }
        } else {
            Product vProductNull = new Product();
            return new ResponseEntity<>(vProductNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete product by id
    @DeleteMapping("/products/{productId}")
    private ResponseEntity<Object> deleteProductById(
            @PathVariable Integer productId) {
        Optional<Product> vProductData = gProductRepository.findById(productId);
        if (vProductData.isPresent()) {
            try {
                gProductRepository.deleteById(productId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Product vProductNull = new Product();
            return new ResponseEntity<>(vProductNull, HttpStatus.NOT_FOUND);
        }
    }

}
