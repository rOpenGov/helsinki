test_that("wfs_api() works correctly", {
  expect_error(wfs_api(base.url = NULL))
  expect_error(wfs_api(base.url = "gopher://gopher.quux.org"))
})

test_that("deprecations produce warnings", {
  expect_warning(get_hsy(which.data = "Vaestotietoruudukko"))
  expect_warning(get_hsy(which.data = "Rakennustietoruudukko"))
  expect_error(get_hsy())
  expect_warning(get_hsy(which.data = "else"))
})
