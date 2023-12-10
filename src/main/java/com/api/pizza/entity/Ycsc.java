package com.api.pizza.entity;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "ycsc")
public class Ycsc extends BaseEntity {

    @Column(name = "title")
    private String title;

    @Column(name ="month")
    private String month;
    
    @Column(name ="year")
    private String year;
   
    @Column(name ="index")
    private Integer index;

    //ManyToOne
    @Column(name = "department")
    private String department;

    // @Column (department)
    
    /* Bấm nút tạo
        Bước 1: Dò phiếu ycsc để lấy chuỗi cố định theo khu vực
        Bước 2: Filter theo tháng để lấy theo tháng và năm
        Bước 3: Tạo phiếu mới đúng số tháng, chỉ mục là số lớn nhất trong danh sách theo tháng và khu vực + 1
        Bước 4: Load lại thông tin ra màn hình theo khu vực
    */


 /* Điều kiện cần của ycsc database
  1. title 
  2. liên kết department
  3. month/year
  4. index

  */
}
