<script>
  import { createEventDispatcher } from 'svelte';

  const presets = ['build', 'server', 'plain', 'csv'];
  const dispatch = createEventDispatcher();

  function choose(name) {
    dispatch('change', { name });
  }
</script>

<select class="preset-picker" on:change={(e) => choose(e.target.value)}>
  {#each presets as name}
    <option value={name}>{name}</option>
  {/each}
</select>
