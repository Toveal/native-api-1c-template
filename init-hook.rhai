let objects = [];

while true {
    let input = variable::prompt("Input addin name or stop", "stop", "^[A-Z][a-zA-Z0-9]*$|^stop");
    
    if input == "stop" {
        break;
    } else if objects.contains(input) {
        continue;
    } else {
        objects.push(input);
    }
}

let mods_placeholder = "";
let use_lib_placehol = "";
let class_names_placehol = "";
let math_class_placehol = "";

let it = 0;
let last_obj = objects.len() - 1;

while it <= last_obj {
    let obj = objects[it];

    let file_name = to_snake_case(obj) + ".rs";
    let template = get_template(obj);
    file::write("src/" + file_name, template);

    let snake_mod = to_snake_case(obj);
    mods_placeholder += get_mods_block(snake_mod);

    if last_obj == it {
        class_names_placehol += obj;
    } else {
        class_names_placehol += obj + "|";
    }
    math_class_placehol += get_math_block(obj, snake_mod);

    it += 1;
}

variable::set("mods_lib", mods_placeholder);
variable::set("class_names_get", class_names_placehol);
variable::set("match_comp_name", math_class_placehol);

fn get_mods_block(object_name) {
    return `mod ${object_name};${"\n"}`;
}

fn get_math_block(object_name, mod_name) {
    return `
    "${object_name}" => {
        let addin = ${mod_name}::${object_name}::new();
        Box::into_raw(Box::new(addin)) as *const u8
    },
    `;
}

fn get_template(object_name) {
    return `{% if library_option == "complex" %}use native_1c::component::IComponentBase;
use native_1c::native_macro::native_object;
use native_1c::types::Variant;

#[native_object]
#[repr(C)]
pub struct ${object_name} {
}

impl IComponentBase for ${object_name} {
    fn init(&mut self) -> bool {
        true
    }

    fn get_info(&self) -> i32 {
        2000
    }

    fn done(&mut self) {}

    fn get_n_props(&self) -> i32 {
        0
    }

    fn find_prop(&self, prop_name: &str) -> i32 {
        match prop_name {
            _ => unreachable!(),
        }
    }

    fn get_prop_name(&self, prop_num: i32, prop_alias: i32) -> &str {
        match prop_num {
            _ => unreachable!(),
        }
    }

    fn get_prop_val(&self, prop_num: i32, var_prop_val: &mut Variant) -> bool {
        match prop_num {
            _ => return false,
        }
        true
    }

    fn set_prop_val(&mut self, prop_num: i32, var_prop_val: &Variant) -> bool {
        match prop_num {
            _ => return false,
        }
        true
    }
    fn is_prop_readable(&self, _prop_num: i32) -> bool {
        true
    }

    fn is_prop_writeable(&self, _prop_num: i32) -> bool {
        true
    }

    fn get_n_methods(&self) -> i32 {
        0
    }

    fn find_method(&self, method_name: &str) -> i32 {
        match method_name {
            _ => unreachable!(),
        }
    }
    fn get_method_name(&self, method_num: i32, method_alias: i32) -> &str {
        match method_num {
            _ => unreachable!(),
        }
    }
    fn get_n_params(&self, method_num: i32) -> i32 {
        match method_num {
            _ => 0,
        }
    }
    fn get_param_def_value(
        &self,
        method_num: i32,
        param_num: i32,
        var_param_def_value: &mut Variant,
    ) -> bool {
        match method_num {
            _ => return false,
        }
        true
    }
    fn has_ret_val(&self, _method_num: i32) -> bool {
        true
    }

    fn call_as_proc(&mut self, _method_num: i32, _params: Option<&mut [Variant]>) -> bool {
        true
    }

    fn call_as_func(
        &mut self,
        method_num: i32,
        ret_vals: &mut Variant,
        params: Option<&mut [Variant]>,
    ) -> bool {
        match method_num {
            _ => return false,
        }
        true
    }

    fn set_locale(&mut self, _loc: &str) {}
}

impl ${object_name} {
}
{% else %}use std::sync::Arc;

use native_api_1c::{
    native_api_1c_core::ffi::connection::Connection, 
    native_api_1c_macro::AddIn
};

#[derive(AddIn)] 
pub struct ${object_name} { 
    #[add_in_con] // соединение с 1С для вызова внешних событий 
    connection: Arc<Option<&'static Connection>>, // Arc для возможности многопоточности 
}

impl ${object_name} {
    pub fn new() -> Self {
        Self {
            connection: Arc::new(None),
        }
    }
}
{% endif %}
#[cfg(test)]
mod tests {
    {% if use_insta == true %}use insta::{assert_debug_snapshot, assert_snapshot};{% endif %}
}`;
}
