import "../scripts/get_name_addins.rhai" as get_names;

let objects = get_names::get_addin_names();

let lib_mods_addin = "";

for obj in objects {
    let snake_obj = to_snake_case(obj);
    let template = get_template(obj);
    file::write(`src/${snake_obj}.rs`, template);

    lib_mods_addin += `mod ${snake_obj};${"\n"}`;

    variable::set("lib_mods_addin", lib_mods_addin);
}

fn get_template(object_name) {
    return 
    `use std::sync::Arc;
use native_api_1c::{native_api_1c_core::ffi::connection::Connection, native_api_1c_macro::AddIn};

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

#[cfg(test)]
mod tests {
    use insta::{assert_debug_snapshot, assert_snapshot};
}`;
}