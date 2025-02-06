def _impl(ctx):

    header = ctx.actions.declare_file("inc/circle.hpp")
    source = ctx.actions.declare_file("circle.cpp")

    args = ctx.actions.args()
    args.add("-i", header)
    args.add("-s", source)

    ctx.actions.run(
        outputs = [header, source],
        arguments = [args],
        executable = ctx.executable.pythongen,
    )

    c_context = cc_common.create_compilation_context(
        headers = depset([header]),
    )

    return [
        DefaultInfo(files = depset([header, source])),
        CcInfo(compilation_context=c_context),
    ]
circleGen = rule(
    implementation = _impl,
    attrs = {
        "generator" : attr.label(
            executable = True,
            cfg = "exec",
            allow_files = True,
            default = "//project/generators/python:pythongen",
        )
    },
)