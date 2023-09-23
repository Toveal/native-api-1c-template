mod addin;

{% if library_option == "complex" %}
use native_1c::component::AppCapabilities;
use native_1c::widestring::{U16CStr, U16CString};
use native_1c::OnceCell;
use std::os::raw::c_long;
use addin::{{addin_name}};

static CLASS_NAMES: OnceCell<Vec<u16>> = OnceCell::new();

#[no_mangle]
unsafe extern "C" fn GetClassObject(_name: *const u16, component: *mut *const u8) -> c_long {
    let Ok(name) = U16CStr::from_ptr_str(_name).to_string() else {
        return 0;
    };
    *component = match name.as_str() {
        "{{addin_name}}" => {
            let addin = {{addin_name}}::new();
            Box::into_raw(Box::new(addin)) as *const u8
        }
        _ => return 0,
    };
    component as c_long
}

#[no_mangle]
unsafe extern "C" fn DestroyObject(_component: *mut *const u8) -> c_long {
    0
}

#[no_mangle]
unsafe extern "C" fn GetClassNames() -> *const u16 {
    CLASS_NAMES
        .get_or_init(|| {
            U16CString::from_str("{{addin_name}}")
                .unwrap()
                .as_slice_with_nul()
                .to_vec()
        })
        .as_ptr()
}

#[no_mangle]
unsafe extern "C" fn SetPlatformCapabilities(capabilities: AppCapabilities) -> AppCapabilities {
    capabilities
}


#[cfg(test)]
mod tests {
    use super::GetClassNames;
    use insta::{assert_debug_snapshot, assert_snapshot};

    fn get_class_names() {
        let class_names = unsafe { GetClassNames() };
        assert!(!class_names.is_null());
    }
}

{% endif %}