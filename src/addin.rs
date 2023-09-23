{% if library_option == "complex" %}
use native_1c::component::IComponentBase;
use native_1c::native_macro::native_object;
use native_1c::types::Variant;

#[native_object]
#[repr(C)]
pub struct {{addin_name}} {
    pub port: u32,
    pub test_string: String,
}

impl IComponentBase for {{addin_name}} {
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

impl {{addin_name}} {
}
{% else %}
use std::sync::Arc;

use native_api_1c::{
    native_api_1c_core::ffi::connection::Connection, 
    native_api_1c_macro::AddIn
};

#[derive(AddIn)] 
pub struct {{addin_name}} { 
    #[add_in_con] // соединение с 1С для вызова внешних событий 
    connection: Arc<Option<&'static Connection>>, // Arc для возможности многопоточности 
}

impl {{addin_name}} {
    pub fn new() -> Self {
        Self {
            connection: Arc::new(None),
        }
    }
}

{% endif %}

#[cfg(test)]
mod tests {
    use insta::{assert_debug_snapshot, assert_snapshot};
}
