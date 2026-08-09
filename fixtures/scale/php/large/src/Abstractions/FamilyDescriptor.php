<?php

namespace CipherLab\Abstractions;

// Metadata plus factory methods for one cipher family; every family
// under Families/ provides exactly one implementing class.
interface FamilyDescriptor
{
    public function family(): string;
    public function suite(): string;
    public function cipher(): Cipher;

    /** @return TestVector[] */
    public function vectors(): array;
}
