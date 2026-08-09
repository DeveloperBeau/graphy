<?php

// Minimal PSR-4-style autoloader so index.php does not need one
// require_once line per class; maps the CipherLab\ prefix onto src/.
spl_autoload_register(function (string $class): void {
    $prefix = 'CipherLab\\';
    if (!str_starts_with($class, $prefix)) {
        return;
    }
    $relative = substr($class, strlen($prefix));
    $path = __DIR__ . '/' . str_replace('\\', '/', $relative) . '.php';
    if (is_file($path)) {
        require_once $path;
    }
});
