define(["jquery","ui/scrollTable"],function(a){!function(){var b,c=a("#contextLine"),d={removable:!1,selectElement:!1,selectHandler:function(a){window.location.href="/admin/work/insert/"+a.id}},e=c.find("#searchCustomer"),f=c.find(".customer-table").scrollTable(d).scrollTable("instance"),g=e.find("input");e.on("popOn",function(){f.clear(),g.val("")}),g.on("keyup",function(c){var d=g.val();if(b!==(d=a(c.target).val())){if(0===d.length)return g.val(""),void f.clear();b=d,/^[가-힣|\w|\s]+$/.test(d)&&a.getJSON("/admin/customer/search/name/"+d).success(function(a){f.clear(),f.addList(a)})}})}()});
//# sourceMappingURL=context.js.map