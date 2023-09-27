import "../scripts/get_name_addins.rhai" as get_names;

let objects = get_names::get_addin_names();

let mods_placeholder = "";
let use_lib_placehol = "";
let class_names_placehol = "";
let math_class_placehol = "";

let it = 0;
let last_obj = objects.len() - 1;

while it <= last_obj {
    let obj = objects[it];

    let obj_snake = to_snake_case(obj);
    let template = get_template(obj);
    file::write(`src/${obj_snake}.rs`, template);

    mods_placeholder += `mod ${obj_snake};${"\n"}`;

    if last_obj == it {
        class_names_placehol += obj;
    } else {
        class_names_placehol += obj + "|";
    }
    math_class_placehol += get_math_block(obj, obj_snake);

    it += 1;
}

variable::set("lib_mods_addin", mods_placeholder);
variable::set("lib_class_names", class_names_placehol);
variable::set("lib_mach_object_name", math_class_placehol);

fn get_math_block(object_name, mod_name) {
    return 
    `"${object_name}" => {
            let addin = ${mod_name}::${object_name}::new();
            Box::into_raw(Box::new(addin)) as *const u8
    },
    `;
}

fn get_template(object_name) {
    return 
    `use native_1c::component::IComponentBase;
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
}`;
}