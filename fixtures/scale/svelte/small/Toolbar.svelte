<script>
  import PresetPicker from './PresetPicker.svelte';
  import WidthSlider from './WidthSlider.svelte';
  import UploadDrop from './UploadDrop.svelte';

  import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher();

  function forwardPreset(event) {
    dispatch('preset', event.detail);
  }
</script>

<header class="toolbar">
  <PresetPicker on:change={forwardPreset} />
  <WidthSlider />
  <UploadDrop />
</header>

<style>
  .toolbar {
    display: flex;
    gap: 0.75rem;
    padding: 0.5rem 1rem;
  }
</style>
