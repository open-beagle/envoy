load(
    "//bazel:envoy_build_system.bzl",
    "envoy_cc_test_library",
    "envoy_package",
)

licenses(["notice"])  # Apache 2

envoy_package()

envoy_cc_test_library(
    name = "custom_lb_policy",
    srcs = [
        "custom_lb_policy.cc",
    ],
    hdrs = [
        "custom_lb_policy.h",
    ],
    deps = [
        "//envoy/upstream:load_balancer_interface",
        "//source/common/upstream:load_balancer_factory_base_lib",
        "//test/test_common:registry_lib",
    ],
)
