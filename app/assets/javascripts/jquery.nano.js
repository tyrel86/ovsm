/* Nano Templates (Tomasz Mazur, Jacek Becela) */
/* @see https://github.com/trix/nano */
(function($){
  $.nano = function(template, data) {
    return template.replace(/\{([\w\.]*)\}/g, function (str, key) {
      var keys = key.split("."), value = data[keys.shift()];
      $.each(keys, function () { value = value[this]; });
      return (value === null || value === undefined) ? "" : value;
    });
  };
  /* Seven lines of additional code to Nano Templates (Terry Young) */
  $.fn.outerHTML = function () { return $(this).wrapAll('<div />').parent().html(); };
  $.template = function($template, oData) { return $($.nano($template.outerHTML(), oData)); };
  $.populate = function($template, arrData) {
      var $elems = $();
      $.each(arrData, function(i, obj) {$elems = $elems.add($.template($template, obj).data('data', obj));});
      return $elems;
  };    
})(jQuery);
