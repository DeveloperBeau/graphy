<script>
  import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher();

  function acceptFile(event) {
    const file = event.dataTransfer.files[0];
    dispatch('file', { name: file.name });
  }
</script>

<div class="upload-drop" role="button" tabindex="0" on:drop|preventDefault={acceptFile}>
  Drop a log file here
</div>

<style>
  .upload-drop {
    border: 2px dashed #8892a0;
    padding: 0.4rem 1rem;
    border-radius: 6px;
  }
</style>
