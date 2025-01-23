# async-opcua (Rust) EUROMAP generation reproduction repository


## How to use this repository
Pursuant to the [OPC Foundation Specifications Agreement](https://opcfoundation.org/license/specifications/1.15/index.html), I have no idea if I am allowed to share the specification files by way of including them in this repository

As such, I have provided shell and PowerShell scripts to facilitate the retrieval of the required specifications

## How to initialize the environment
Run `get_specs.sh` or `get_specs.ps1` to retrieve the required EUROMAP OPCUA specifications

Run `git submodule update --init` to retrieve the required OPCUA specifications from the `async-opcua` repository

Ensure `async-opcua-codegen` is installed
e.g.
```
git submodule update --init
cargo install --path external/async-opcua/async-opcua-codegen/
```

Invoke the generation
```
async-opcua-codegen.exe codegen.yml
```

## What to expect
Currently, the submodule is pinned to the `improve-code-gen-error-context` branch

[PR](https://github.com/FreeOpcUa/async-opcua/pull/34)

[Commit](https://github.com/FreeOpcUa/async-opcua/commit/bf3d50d74e6fcc9548e62655f57a61166cf3ef42)

[Master (1 commit behind PR)](https://github.com/FreeOpcUa/async-opcua/commit/885c3bb6c525b2665e07b14bfacfa35f76c8cbaa)


### CodeGenError
When invoking code generation using the steps outlined above, this error is returned
(Error has been slightly formatted for readability)
```
Error: CodeGenError {
    kind: Other("Unsupported content type of type DataSetMetaDataType"),
    context: Some("generating node ns=1;i=6104"),
    file: Some("EUROMAP/EUROMAP_79/Opc.Ua.PlasticsRubber.ImmToRobot.xml")
}
```
___