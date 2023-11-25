use hyper_proxy::{Intercept, Proxy};

fn main() {
    Proxy::new(Intercept::All, "localhost:8000".parse().expect("whups"));
}
