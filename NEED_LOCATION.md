# ملخص الموقف الحالي - الحل الحقيقي

## ✅ ما اكتشفته:

1. **البيانات تُحمّل من Google Sheets CSV**
2. **دالة `parseRowsFull()` تعالج CSV**
3. **توجد دوال معرّفة محلياً:**
   - `pn()` - parser رقمي
   - `pol()` - لكن غير مستخدمة
   - `detectPolarity()` - موجودة
   - `calcComp()` - موجودة ومحدثة بشكل صحيح

4. **المشكلة:** 
   - `parseRowsFull()` **لا تحسب completion للمؤشرات الفردية**
   - فقط تحسب للأقسام (depts)
   - هناك دالة `recalculateAllData()` تحسبها **بعد** تحميل البيانات

---

## 🔧 الحل المطلوب:

يجب إضافة حساب `completion` **أثناء** معالجة CSV في `parseRowsFull()`.

### أين يتم إنشاء rows من CSV؟

**أنا بحاجة معرفة:**

في `parseRowsFull()` - أين يتم عمل loop على `rows` array وإنشاء l2, l3, l4 objects؟

**المفقود:** كود يشبه هذا:
```javascript
for (var i = 0; i < rows.length; i++) {
  var row = rows[i];
  // هنا يتم استخراج البيانات من الـ row
  // هنا يجب إضافة:
  // obj.completion = calcComp(obj.achieved, obj.target, obj.baseline);
  // ثم إضافة obj إلى l2 أو l3 أو l4
}
```

---

## 🎯 ما أحتاج:

**أخبرني أين بالضبط في `parseRowsFull()`:**

السطر تقريباً الذي يتم فيه:
- إنشاء المؤشرات من الـ rows
- أو على الأقل: أين يتم إضافة العناصر إلى `l2`

**سطر أو نطاق سطور من `parseRowsFull()`**

