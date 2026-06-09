import app/router
import gleam/http
import gleeunit
import gleeunit/should
import wisp/simulate

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn home_returns_200_test() {
  let response = router.handle_request(simulate.request(http.Get, "/"))

  response.status
  |> should.equal(200)
}
