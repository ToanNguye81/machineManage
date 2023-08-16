package com.api.pizza.controller;

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

import com.api.pizza.entity.SparePart;
import com.api.pizza.repository.ISparePartRepository;

@RestController
@CrossOrigin
@RequestMapping("/")
public class SparePartController {
    @Autowired
    ISparePartRepository gSparePartRepository;

    // get all SparePart
    @GetMapping("/spare-part")
    public ResponseEntity<List<SparePart>> getAllSpareParts() {
        try {
            List<SparePart> sparePartList = gSparePartRepository.findAll();
            Long totalElement = (long) sparePartList.size();

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(sparePartList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // create new de
    @PostMapping("/spare-part")
    public ResponseEntity<Object> createNewSparePart(
            @Valid @RequestBody SparePart pSparePart) {
        try {
            SparePart vSparePart = new SparePart();
            vSparePart.setName(pSparePart.getName());
            vSparePart.setCode(pSparePart.getCode());
            vSparePart.setPrice(pSparePart.getPrice());
            SparePart vSparePartSave = gSparePartRepository.save(vSparePart);
            return new ResponseEntity<>(vSparePartSave, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity()
                    .body("Failed to Create specified SparePart: " + e.getCause().getCause().getMessage());
        }

    }

    // get de by id
    @GetMapping("/spare-part/{sparePartId}")
    public ResponseEntity<Object> getNameById(
            @PathVariable Integer sparePartId) {
        Optional<SparePart> vSparePartData = gSparePartRepository.findById(sparePartId);
        if (vSparePartData.isPresent()) {
            try {
                SparePart vSparePart = vSparePartData.get();
                return new ResponseEntity<>(vSparePart, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            SparePart vSparePartNull = new SparePart();
            return new ResponseEntity<>(vSparePartNull, HttpStatus.NOT_FOUND);
        }
    }

    // Update de by id
    @PutMapping("/spare-part/{sparePartId}")
    public ResponseEntity<Object> updateSparePart(
            @PathVariable Integer sparePartId,
            @Valid @RequestBody SparePart pSparePart) {
        Optional<SparePart> vSparePartData = gSparePartRepository.findById(sparePartId);
        if (vSparePartData.isPresent()) {
            try {
                SparePart vSparePart = vSparePartData.get();
                vSparePart.setName(pSparePart.getName());
                vSparePart.setCode(pSparePart.getCode());
                vSparePart.setPrice(pSparePart.getPrice());

                SparePart vSparePartSave = gSparePartRepository.save(vSparePart);
                return new ResponseEntity<>(vSparePartSave, HttpStatus.OK);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Update specified SparePart: " + e.getCause().getCause().getMessage());
            }
        } else {
            SparePart vSparePartNull = new SparePart();
            return new ResponseEntity<>(vSparePartNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete de by id
    @DeleteMapping("/spare-part/{sparePartId}")
    private ResponseEntity<Object> deleteSparePartById(
            @PathVariable Integer sparePartId) {
        Optional<SparePart> vSparePartData = gSparePartRepository.findById(sparePartId);
        if (vSparePartData.isPresent()) {
            try {
                gSparePartRepository.deleteById(sparePartId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            SparePart vSparePartNull = new SparePart();
            return new ResponseEntity<>(vSparePartNull, HttpStatus.NOT_FOUND);
        }
    }

}
