test_that("wfs_api() works correctly", {
  expect_error(wfs_api(base.url = NULL))
  expect_error(wfs_api(base.url = "gopher://gopher.quux.org"))
  suppressMessages(expect_message(wfs_api(base.url = "https://httpstat.us/404", queries = "search")))
  suppressMessages(expect_message(wfs_api(base.url = "https://httpstat.us/200", 
                                          queries = c("sleep" = 11000))))
})

test_that("get_city_map() works correctly", {
  # Non-supported city
  expect_error(get_city_map(city = "porvoo"))
  # Non-supported level
  expect_error(get_city_map(city = "helsinki", level = "keskialue"))
  # Extremely short timeout parameter (1 ms) to ensure connection timeout
  suppressMessages(expect_message(get_city_map(city = "helsinki",
                                               level = "suuralue",
                                               timeout.s = 0.001)))
})
