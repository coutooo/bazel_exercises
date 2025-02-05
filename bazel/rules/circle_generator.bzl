""" TODO: Write docstrings
"""

def _impl(ctx):
    """ TODO: Write docstring
    """

    header = ctx.actions.declare_file("inc/circle.hpp")
    source = ctx.actions.declare_file("circle.cpp")

    args = ctx.actions.args()
    args.add("-i", header)
    args.add("-s", source)

    ctx.actions.run(
        outputs = [header, source],
        arguments = [args],
        executable = ctx.executable._tool,
    )

    c_context = cc_common.create_compilation_context(
        headers = depset([header]),
    )

    return [
        DefaultInfo(files = depset([header, source])),
        CcInfo(compilation_context=c_context),
    ]

circle_gen = rule(
    implementation = _impl,
    attrs = {
        "_tool": attr.label(
            default = "//project/generators/python:circle_generator",
            executable = True,
            cfg = "exec",
        ),
    },
)
