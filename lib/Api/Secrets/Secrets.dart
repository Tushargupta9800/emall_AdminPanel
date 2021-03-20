String DomainUrl = "https://gulfemall.herokuapp.com";

String GetDeliveryChargesUrl = DomainUrl + "/api/adminpanel/retrivecharges";
String ChangeDeliveryChargesUrl = DomainUrl + "/api/adminpanel/forgetpassword/admin/changedeliverycharge/"; //+charges

String LoginUrl = DomainUrl + "/api/adminpanel/checkadminpassword";

String CategoryUrl = DomainUrl + "/api/get/get/category";
String AddCategoryUrl = DomainUrl + "api/addproduct/add/category/"; //+ english/arabic
String SubCategoryUrl = DomainUrl + "/api/get/get/subcategory";
String AddSubCategoriesUrl = DomainUrl + "/api/addproduct/add/subcategory/";

String UserPaymentDoneUrl = DomainUrl + "/api/payment/userpayment"; //{order_id: “string”}
String CustomerPaymentDoneUrl = DomainUrl + "/api/payment/customerpayment"; //{order_id: “string”}

String ViewSalesUrl = DomainUrl + "/api/adminpanel/viewsales";
String VenderPaymentUrl = DomainUrl + "/api/adminpanel/venderpayment";
String IncompleteOrdersUrl = DomainUrl  + "/api/adminpanel/incompleteorder";

String GetAllNonvalidateUsersUrl = DomainUrl + "/api/tobevalidate/unvalidatevenders";
String ValidateTheUserUrl = DomainUrl + "/api/validate/validatingvenders/"; //id

String CustomerPaymentConfirmationUrl = DomainUrl + "/api/payment/customerpayment";
String VenderPaymentConfirmUrl = DomainUrl + "/api/payment/userpayment";

String DeleteSubCategoryUrl = DomainUrl + "";
