use std::env;
use std::path::PathBuf;

fn main() {
    let cwd = env::args()
        .nth(1)
        .map(PathBuf::from)
        .unwrap_or_else(|| env::current_dir().expect("current dir"));

    println!("__APP_NAME__-helper: cwd={} runtime=rust", cwd.display());
}
