<script>
  import OutputLine from './OutputLine.svelte';
  import EmptyHint from './EmptyHint.svelte';

  export let lines = [];
  export let preset = 'plain';
</script>

<section class="preview-pane" data-preset={preset}>
  {#if lines.length === 0}
    <EmptyHint />
  {:else}
    {#each lines as line, i}
      <OutputLine text={line} number={i + 1} />
    {/each}
  {/if}
</section>

<style>
  .preview-pane {
    font-family: monospace;
    overflow-y: auto;
    padding: 0.75rem 1rem;
  }
</style>
