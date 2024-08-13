param(
    [String] $pfx,
    [String] $exe
)

echo @"
`$pfx="$pfx"
`$exe="$exe"

# copy arguments
`$_args = `$args

if (`$_args.Length -gt 0) {
    if (`$_args[0] -eq "list") {
        echo "Contents of `$pfx\\scripts"
        (Get-ChildItem `$pfx\\scripts -Filter "*.bms").name
        exit 0
    }
    `$a = `$_args[0];
    `$b = `$pfx + "scripts\\" + `$a

    `$ae = `$(Test-Path `$a)
    `$be = `$(Test-Path `$b)

    # test script exists
    if (! `$be) {
        if (! `$ae) {
            echo "script `$a not found here or in `$pfx\\scripts";
            echo "to list all scripts, run: quickbms.ps1 list"
            exit -1;
        } else {
            `$_args[0] = `$a;
        }
    } else {
        `$_args[0] = `$b;
    }
}

# forward all arguments
& `$exe @_args

"@
