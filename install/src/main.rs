use std::{
    fs,
    path::{Path, PathBuf},
};

use clap::Parser;
use dialoguer::Confirm;
use dirs::home_dir;
use walkdir::WalkDir;

#[derive(Parser, Debug)]
struct Args {
    root: PathBuf,
}

fn main() {
    let args = Args::parse();
    let root_dir = args.root.clone();

    for entry in WalkDir::new(args.root) {
        let root_dir = root_dir.as_path();

        let entry = entry.expect("Error while iterating over directory entries");
        let file_path = entry.path();

        if file_path.is_file() {
            let file_path_buf = PathBuf::from(file_path);
            let file_path = file_path_buf.as_path();

            let relative_path_buf = get_relative_path(root_dir, file_path);
            let relative_path = relative_path_buf.to_str().unwrap();
            let actual_path = evaluate_path(relative_path);
            let backup_path = format!("{}{}", actual_path, ".bak");

            println!("Relative path: {}", &relative_path);
            println!("Actual path: {}", actual_path);
            println!("Backup path: {}", backup_path);

            if file_exists(&actual_path) {
                print!("File exists");
                if file_exists(&backup_path) {
                    print!(" AND .bak File exsits");
                }
                println!();

                let should_replace = Confirm::new()
                    .default(true)
                    .with_prompt("Replace file anyways?")
                    .wait_for_newline(true)
                    .interact()
                    .unwrap();
                if should_replace {
                    println!("REPLACE FILE");
                } else {
                    println!("DONT REPLACE FILE");
                }
            }
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

fn evaluate_path(path: &str) -> String {
    let expanded_path = if path.starts_with('~') {
        if let Some(home) = home_dir() {
            path.replacen('~', home.to_str().unwrap(), 1)
        } else {
            path.to_string()
        }
    } else {
        path.to_string()
    };

    expanded_path
}

fn file_exists(file_path: &str) -> bool {
    if let Ok(metadata) = fs::metadata(file_path) {
        metadata.is_file()
    } else {
        false
    }
}
