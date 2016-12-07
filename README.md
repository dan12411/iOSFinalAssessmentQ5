# iOSFinalAssessmentQ5

[![Travis branch](https://img.shields.io/travis/rust-lang/rust/master.svg)]()

題目：

![](https://github.com/dan12411/iOSFinalAssessmentQ5/blob/master/Q5-1.png)

![](https://github.com/dan12411/iOSFinalAssessmentQ5/blob/master/Q5-2.png)

![](https://github.com/dan12411/iOSFinalAssessmentQ5/blob/master/Q5-3.png)

---

實作過程：

1. 建立UITableViewController & UITableViewCell

2. 用假資料測試TableView顯示照片和資料的結果

3. 先啟用向左滑動，刪除Cell資料的功能

4. 實作點選Cell後，進入detail頁面，顯示300X300圖在中央 ＆ 加入可輸入編輯的欄位

5. 增加navigationItem(addPhoto & share)，並實作功能

6. 加上ScrollView，新增兩指縮放功能

7. 嘗試將照片存在.documentDirectory，並測試是否有存在APP裡

8. 用Realm & FileManager 來儲存圖片和文字，load image轉data...(參考資料 3.)

9. 將圖片的註解(TextField)內容，可編輯，並儲存起來，IBAction 用 Editing Change ，才不會使用者再輸入時，又按返回鍵，會發生 crash 的問題...(參考資料 3.)

10. 將 UITextField Constraint，當鍵盤出現後，Constraint 做變更(上升)，避免輸入時，TextFiled 會被鍵盤擋住的問題...(參考資料 4.)

---

參考資料：

1. [Realm](https://realm.io/docs/swift/latest/#writes)

2. [Save & Load image from FileManager ](http://stackoverflow.com/questions/35685685/how-to-save-an-image-picked-from-a-uiimagepickercontroller-in-swift)

3. [Use Editing Change](http://stackoverflow.com/questions/7010547/uitextfield-text-change-event)

4. [UITextField Constraint](http://stackoverflow.com/questions/25693130/move-textfield-when-keyboard-appears-swift)


