fn get_addin_names() {
    let objects = [];

    while true {
        let input = variable::prompt("Enter the name of the component or stop", "stop", "^[A-Z][a-zA-Z0-9]*$|^stop");
        
        if input == "stop" {
            break;
        } else if objects.contains(input) {
            print(`${"\u274C"}   ${input} already exists`);
            continue;
        } else {
            objects.push(input);
        }
    }

    return objects;
}