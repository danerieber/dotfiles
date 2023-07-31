use std::path::{Path, PathBuf};

use clap::Parser;
use walkdir::WalkDir;

#[derive(Parser, Debug)]
struct Args {
    root: PathBuf,
}

fn main() {
    let args = Args::parse();
    let root_dir = args.root.clone();

    for entry in WalkDir::new(args.root) {
        let root = root_dir.clone();

        let entry = entry.expect("Error while iterating over directory entries");
        let file_path = entry.path();

        if file_path.is_file() {
            let file_path_buf = PathBuf::from(file_path);

            let relative_path = get_relative_path(&root, &file_path_buf);

            println!("Relative path: {}", relative_path.to_str().unwrap());
        }
    }
}

fn get_relative_path(root_dir: &Path, file_path: &Path) -> PathBuf {
    if let Ok(relative_path) = file_path.strip_prefix(root_dir) {
        PathBuf::from(relative_path)
    } else {
        file_path.to_path_buf()
    }
}
